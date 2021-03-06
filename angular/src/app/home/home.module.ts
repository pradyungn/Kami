import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeRoutingModule } from './home-routing.module';
import { SharedModule } from '../shared/shared.module';

import { HomeComponent } from './home.component';
import { LoginComponent } from './login/login.component';
import { AnimationComponent } from './animation/animation.component';

@NgModule({
  declarations: [HomeComponent, LoginComponent, AnimationComponent],
  imports: [
    CommonModule, 
    SharedModule, 
    HomeRoutingModule
  ]
})
export class HomeModule {}
