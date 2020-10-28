import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Post} from "../model/post";

@Injectable({
  providedIn: 'root'
})
export class PostServiceService {

  private baseUrl = './api';

  constructor(private http: HttpClient) { }

  getPostList(): Observable<any> {
    return this.http.get(`${this.baseUrl}/post/all`);
  }

  createPost(post: Post): Observable<Object> {
    return this.http.post(`${this.baseUrl}/post/create`, post);
  }
}
