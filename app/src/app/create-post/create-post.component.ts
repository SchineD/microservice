import {Component, EventEmitter, OnInit, Output} from '@angular/core';
import {Post} from "../model/post";
import {PostServiceService} from "../service/post-service.service";
import {DisplayPostComponent} from "../display-post/display-post.component";

@Component({
  selector: 'create-post',
  templateUrl: './create-post.component.html',
  styleUrls: ['./create-post.component.sass']
})
export class CreatePostComponent implements OnInit {

  post = new Post();

  @Output() postEvent = new EventEmitter();

  constructor(private postServiceService : PostServiceService) { }

  ngOnInit(): void {
  }

  sendPost(post: Post) {
    this.postServiceService.createPost(post).subscribe(data => {
      console.log(data);
      this.postEvent.emit(null);
    });
  }
}
