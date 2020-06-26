import { Component, ViewEncapsulation } from '@angular/core';
import { Subject, Observable } from 'rxjs';
import {
  debounceTime,
  distinctUntilChanged,
  switchMap,
  filter,
} from 'rxjs/operators';
import { SearchService } from './search.service';
import { Book } from './book';
import { DomSanitizer } from '@angular/platform-browser';
import { Router, NavigationStart } from '@angular/router';
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
  input = '';
  private querySub = new Subject<string>();

  readonly books$ = this.querySub.pipe(
    debounceTime(250),
    distinctUntilChanged(),
    switchMap((query: string) => this.searchService.fetchBooks(query))
  );

  constructor(
    private searchService: SearchService,
    private sanitization: DomSanitizer,
    private router: Router
  ) {
    this.router.events
      .pipe(filter((event) => event instanceof NavigationStart))
      .subscribe((_) => {
        this.input = '';
        console.log(this.input);
        console.log('bii');
      });
  }

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
