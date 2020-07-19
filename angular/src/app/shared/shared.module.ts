import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { TranslateModule } from '@ngx-translate/core';

import { 
  AccountHeaderComponent, 
  CameraComponent,
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
    CameraComponent,
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
    CameraComponent,
    FileComponent,
    TextComponent
  ]
})
export class SharedModule {}
