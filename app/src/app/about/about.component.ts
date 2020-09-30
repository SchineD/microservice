import { Component, OnInit } from '@angular/core';
import { CatsService } from "api-swagger-client";

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.sass']
})
export class AboutComponent implements OnInit {

  catsService: CatsService;
  version: string | undefined;

  constructor(catsService: CatsService) {
    this.catsService = catsService;
  }

  ngOnInit(): void {
    this.catsService.getVersion().subscribe(result => this.version = result.value)
  }

}
