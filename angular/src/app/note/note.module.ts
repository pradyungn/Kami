import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { SharedModule } from '../shared/shared.module';

import { NoteComponent } from './note.component';
import { DeleteComponent } from './delete/delete.component';

@NgModule({
  declarations: [NoteComponent, DeleteComponent],
  imports: [
    CommonModule,
    SharedModule,
    RouterModule
  ]
})
export class NoteModule { }
