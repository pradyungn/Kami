#!/usr/bin/env python3

from flask import Flask, request, jsonify
from nltk import sent_tokenize, download, corpus, PorterStemmer, word_tokenize
import math
from PIL import Image
import io
import base64
import pytesseract
import cv2 as cv
import numpy
app = Flask(__name__)

download('stopwords')
download('punkt')

pytesseract.pytesseract.tesseract_cmd = "/usr/bin/tesseract"


def _create_frequency_matrix(sentences):
    frequency_matrix = {}
    stopWords = set(corpus.stopwords.words("english"))
    ps = PorterStemmer()

    for sent in sentences:
        freq_table = {}
        words = word_tokenize(sent)
        for word in words:
            word = word.lower()
            word = ps.stem(word)
            if word in stopWords:
                continue

            if word in freq_table:
                freq_table[word] += 1
            else:
                freq_table[word] = 1

        frequency_matrix[sent[:15]] = freq_table

    return frequency_matrix


def _create_tf_matrix(freq_matrix):
    tf_matrix = {}

    for sent, f_table in freq_matrix.items():
        tf_table = {}

        count_words_in_sentence = len(f_table)
        for word, count in f_table.items():
            tf_table[word] = count / count_words_in_sentence

        tf_matrix[sent] = tf_table

    return tf_matrix


def _create_documents_per_words(freq_matrix):
    word_per_doc_table = {}

    for sent, f_table in freq_matrix.items():
        for word, count in f_table.items():
            if word in word_per_doc_table:
                word_per_doc_table[word] += 1
            else:
                word_per_doc_table[word] = 1

    return word_per_doc_table


def _create_idf_matrix(freq_matrix, count_doc_per_words, total_documents):
    idf_matrix = {}

    for sent, f_table in freq_matrix.items():
        idf_table = {}

        for word in f_table.keys():
            idf_table[word] = math.log10(
                total_documents / float(count_doc_per_words[word]))

        idf_matrix[sent] = idf_table

    return idf_matrix


def _score_sentences(tf_idf_matrix) -> dict:
    sentenceValue = {}

    for sent, f_table in tf_idf_matrix.items():
        total_score_per_sentence = 0

        count_words_in_sentence = len(f_table)
        for word, score in f_table.items():
            total_score_per_sentence += score

        sentenceValue[sent] = total_score_per_sentence / \
            count_words_in_sentence

    return sentenceValue


def _find_average_score(sentenceValue) -> int:
    sumValues = 0
    for entry in sentenceValue:
        sumValues += sentenceValue[entry]

    average = (sumValues / len(sentenceValue))

    return average


def _create_tf_idf_matrix(tf_matrix, idf_matrix):
    tf_idf_matrix = {}

    for (sent1, f_table1), (sent2, f_table2) in zip(tf_matrix.items(),
                                                    idf_matrix.items()):

        tf_idf_table = {}

        for (word1, value1), (word2, value2) in zip(f_table1.items(),
                                                    f_table2.items()):
            tf_idf_table[word1] = float(value1 * value2)

        tf_idf_matrix[sent1] = tf_idf_table

    return tf_idf_matrix


def _generate_summary(sentences, sentenceValue, threshold):
    sentence_count = 0
    summary = ''

    for sentence in sentences:
        if sentence[:15] in sentenceValue and sentenceValue[sentence[:15]] >= (threshold):
            summary += " " + sentence
            sentence_count += 1

    return summary


@app.route('/nlp', methods=['POST'])
def parse(init=""):
    if init != "":
        inp = init
    else:
        content = request.get_json()
        inp = content['input']
    sinp = sent_tokenize(inp)
    slen = len(sinp)

    ft = _create_frequency_matrix(sinp)
    tfm = _create_tf_matrix(ft)
    dpw = _create_documents_per_words(tfm)
    idf = _create_idf_matrix(ft, dpw, slen)
    tdi = _create_tf_idf_matrix(tfm, idf)
    ss = _score_sentences(tdi)
    th = _find_average_score(ss)
    summary = _generate_summary(sinp, ss, th)

    return jsonify({"output": summary})


@app.route("/ocr", methods=['POST'])
def ocr():
    try:
        image = Image.open(request.stream)
    except:
        heif_file = pyheif.read_heif(request.stream)
        image = Image.frombytes(mode=heif_file.mode, size=heif_file.size, data=heif_file.data)
    image = cv.cvtColor(numpy.array(image), cv.COLOR_RGB2BGR)
    image = cv.resize(image, None, fx=1.2, fy=1.2, interpolation=cv.INTER_CUBIC)
    image = cv.cvtColor(image, cv.COLOR_BGR2GRAY)
    image = cv.adaptiveThreshold(image, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C, cv.THRESH_BINARY, 31, 2)
    image = cv.bilateralFilter(image,9,75,75)
    text = pytesseract.image_to_string(image, lang="eng")
    return jsonify({"output": text})


if __name__ == '__main__':
   app.run(host='0.0.0.0', debug=True)
