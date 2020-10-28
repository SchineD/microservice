import { Component, OnInit } from '@angular/core';
import {Post} from "../model/post";
import {PostServiceService} from "../service/post-service.service";

@Component({
  selector: 'display-post',
  templateUrl: './display-post.component.html',
  styleUrls: ['./display-post.component.sass']
})
export class DisplayPostComponent implements OnInit {

  postList? : Post[];

  constructor(private postServiceService : PostServiceService) { }

  ngOnInit(): void {
    this.reloadData();
  }

  reloadData() {
    this.postServiceService.getPostList().subscribe(posts => this.postList = posts);
  }

}
