import { Component, ViewEncapsulation } from '@angular/core';
import { Subject } from 'rxjs';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { SearchService } from './search.service';
import { Book } from './book';
import { DomSanitizer } from '@angular/platform-browser';
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
    switchMap((query: string) => this.searchService.fetchBooks(query))
  );

  constructor(
    private searchService: SearchService,
    private sanitization: DomSanitizer
  ) {}

  sanitize(str: string) {
    return this.sanitization.bypassSecurityTrustUrl(str);
  }
  searchBooks(query: string) {
    this.isSearching = true;
    if (query === '') {
      this.isSearchBoxEmpty = true;
    } else {
      this.isSearchBoxEmpty = false;
    }
    this.books$.subscribe((resp: Array<Book>) => {
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
