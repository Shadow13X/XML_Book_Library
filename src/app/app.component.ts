import { Component, ViewEncapsulation } from '@angular/core';
import { Subject } from 'rxjs';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { SearchService } from './search.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
  encapsulation: ViewEncapsulation.None,
})
export class AppComponent {
  isSearchBoxEmpty = true;
  isNotFound = false;
  isSearching = false;
  private querySub = new Subject<string>();

  readonly books$ = this.querySub.pipe(
    debounceTime(250),
    distinctUntilChanged(),
    switchMap((query) => this.searchService.fetchBooks(query))
  );

  constructor(private searchService: SearchService) {}

  searchBooks(query: string) {
    this.isSearching = true;
    if (query === '') {
      this.isSearchBoxEmpty = true;
    } else {
      this.isSearchBoxEmpty = false;
    }
    this.books$.subscribe((resp: Array<any>) => {
      if (resp.length > 0) {
        this.isNotFound = false;
      } else {
        this.isNotFound = true;
      }
      this.isSearching = false;
      console.log(resp);
    });
    this.querySub.next(query);
  }
}
