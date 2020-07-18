import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { TranslateModule } from '@ngx-translate/core';

import { PageNotFoundComponent } from './components/';
import { WebviewDirective } from './directives/';
import { FormsModule } from '@angular/forms';

import { MaterialModule } from './material.module';

@NgModule({
  declarations: [PageNotFoundComponent, WebviewDirective],
  imports: [
    CommonModule, 
    TranslateModule, 
    FormsModule, 
    MaterialModule
  ],
  exports: [
    TranslateModule, 
    WebviewDirective, 
    FormsModule,
    MaterialModule
  ]
})
export class SharedModule {}
