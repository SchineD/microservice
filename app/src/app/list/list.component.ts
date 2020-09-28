import { Component, OnInit } from '@angular/core';
import { CatsService } from "api-swagger-client";
import { Cat } from "api-swagger-client";

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.sass']
})
export class ListComponent implements OnInit {

  catsService: CatsService;
  cats: Cat[] = [];

  constructor(catsService: CatsService) {
    this.catsService = catsService;
  }

  ngOnInit(): void {
    this.catsService.findAll().subscribe(result => this.cats.push(...result))
  }

}
