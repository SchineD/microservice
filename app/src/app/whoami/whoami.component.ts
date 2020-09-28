import { Component, OnInit } from '@angular/core';
import { CatsService } from "api-swagger-client";

class Header {
  constructor(public name: string, public value: string) {}
}

@Component({
  selector: 'app-whoami',
  templateUrl: './whoami.component.html',
  styleUrls: ['./whoami.component.sass']
})
export class WhoamiComponent implements OnInit {

  catsService: CatsService;
  whoIAm: Header[] = [];

  constructor(catsService: CatsService) {
    this.catsService = catsService;
  }

  ngOnInit(): void {
    this.catsService.whoAmI().subscribe(result => {
      Object.entries(result).map(([key, val]) => this.whoIAm.push(new Header(key, val)));
    });
  }

}
