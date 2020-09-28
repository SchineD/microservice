import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { APP_BASE_HREF } from '@angular/common';
import { HttpClientModule } from "@angular/common/http";

import { ApiModule } from 'api-swagger-client';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { WhoamiComponent } from './whoami/whoami.component';
import { AboutComponent } from './about/about.component';
import { ListComponent } from './list/list.component';

/*
 * Cuts out the first two items if the absolute URL path, this is "/<portal-application>/<portal-role>/"
 */
function getBaseLocation() {
  return '/'+window.location.toString().split('/').slice(3, 5).join('/')+'/';
}

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    WhoamiComponent,
    AboutComponent,
    ListComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ApiModule,
    HttpClientModule
  ],
  providers: [
    {
      provide: APP_BASE_HREF, // needed for absolute links like the URL param in API URL
      useFactory: getBaseLocation
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
