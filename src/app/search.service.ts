import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class SearchService {
  private apiUrl = 'http://localhost/XML_Book_Library/api.php';

  constructor(private http: HttpClient) {}

  fetchBooks(query: string): Observable<any> {
    return this.http
      .get(`${this.apiUrl}?query=${query}`)
      .pipe(catchError((err) => of([])));
  }
}
