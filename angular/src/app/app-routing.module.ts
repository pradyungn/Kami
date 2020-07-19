import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PageNotFoundComponent } from './shared/components';

import { HomeRoutingModule } from './home/home-routing.module';
import { DashboardRoutingModule } from './dashboard/dashboard-routing.module';
import { NoteRoutingModule } from './note/note-routing.module';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'home',
    pathMatch: 'full'
  },
  {
    path: '**',
    component: PageNotFoundComponent
  }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes),
    HomeRoutingModule,
    DashboardRoutingModule,
    NoteRoutingModule
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
