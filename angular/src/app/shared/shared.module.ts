import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { TranslateModule } from '@ngx-translate/core';

import { PageNotFoundComponent } from './components/';
import { WebviewDirective } from './directives/';
import { FormsModule } from '@angular/forms';

import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';

@NgModule({
  declarations: [PageNotFoundComponent, WebviewDirective],
  imports: [
    CommonModule, 
    TranslateModule, 
    FormsModule, 
    MatButtonModule,
    MatInputModule
  ],
  exports: [TranslateModule, WebviewDirective, FormsModule]
})
export class SharedModule {}
