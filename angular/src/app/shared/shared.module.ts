import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { TranslateModule } from '@ngx-translate/core';

import { 
  AccountHeaderComponent,
  FileComponent,
  TextComponent,
  PageNotFoundComponent 
} from './components/';
import { WebviewDirective } from './directives/';
import { FormsModule } from '@angular/forms';

import { MaterialModule } from './material.module';

@NgModule({
  declarations: [
    AccountHeaderComponent,
    FileComponent,
    TextComponent,
    PageNotFoundComponent, 
    WebviewDirective
  ],
  imports: [
    CommonModule, 
    TranslateModule, 
    FormsModule, 
    MaterialModule,
    RouterModule
  ],
  exports: [
    TranslateModule, 
    WebviewDirective, 
    FormsModule,
    MaterialModule,
    AccountHeaderComponent,
    FileComponent,
    TextComponent
  ]
})
export class SharedModule {}
