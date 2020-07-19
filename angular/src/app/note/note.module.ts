import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { SharedModule } from '../shared/shared.module';

import { NoteComponent } from './note.component';

@NgModule({
  declarations: [NoteComponent],
  imports: [
    CommonModule,
    SharedModule,
    RouterModule
  ]
})
export class NoteModule { }
