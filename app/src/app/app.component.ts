import { Component, Inject } from '@angular/core';
import { APP_BASE_HREF } from '@angular/common';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.sass']
})
export class AppComponent {
  title = 'app';

  constructor(@Inject(APP_BASE_HREF) public baseHref: string) { }

  getApiLink(): string {
    return "./api/swagger-ui/index.html?url="+this.baseHref+"api/v3/api-docs";
  }
}
