import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeRoutingModule } from './home-routing.module';

import { HomeComponent } from './home.component';
import { SharedModule } from '../shared/shared.module';
import { LoginComponent } from './login/login.component';

import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';

@NgModule({
  declarations: [HomeComponent, LoginComponent],
  imports: [
    CommonModule, 
    SharedModule, 
    HomeRoutingModule, 
    MatButtonModule,
    MatInputModule
  ]
})
export class HomeModule {}
