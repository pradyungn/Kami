import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DashboardComponent } from './dashboard.component';
import { SharedModule } from '../shared/shared.module';
import { CameraComponent } from './camera/camera.component';
import { FileComponent } from './file/file.component';

@NgModule({
  declarations: [DashboardComponent, CameraComponent, FileComponent],
  imports: [
    CommonModule,
    SharedModule
  ]
})
export class DashboardModule { }
