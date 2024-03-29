require 'library_spec_helper'

describe Book do
  it 'should initalize the name of the book' do
    test_book = Book.new({'name' => "Little Women"})
    expect(test_book).to be_an_instance_of Book
    expect(test_book.name).to eq "Little Women"
  end

  it 'should save the book to the database' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    expect(Book.all).to eq [test_book]
  end

  it 'should update the book name in the database' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    test_book.update_name("Big Women")
    expect(test_book.name).to eq "Big Women"
    expect(Book.all).to eq [test_book]
  end

  it 'should delete the book from the database' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    expect(Book.all).to eq [test_book]
    test_book.delete
    expect(Book.all).to eq []
  end

  it 'should add an author to a book' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    test_author = Author.new({'name' => "Louisa May Alcott"})
    test_author.save
    expect(Book.all).to eq [test_book]
    test_book.add_author(test_author)
    expect(test_book.authors).to eq [test_author]
  end

  it 'should search for a book by author' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    test_author = Author.new({'name' => "Louisa May Alcott"})
    test_author.save
    expect(Book.all).to eq [test_book]
    test_book.add_author(test_author)
    expect(test_book.authors).to eq [test_author]
    expect(Book.search_author(test_author)).to eq [test_book]
  end

  it 'should search for a book by title' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    test_author = Author.new({'name' => "Louisa May Alcott"})
    test_author.save
    expect(Book.all).to eq [test_book]
    test_book.add_author(test_author)
    expect(test_book.authors).to eq [test_author]
    expect(Book.search_title(test_book.name)).to eq [test_book]
  end

  it 'should add a copy of a book to the same book' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    test_author = Author.new({'name' => "Louisa May Alcott"})
    test_author.save
    expect(Book.all).to eq [test_book]
    test_book.add_author(test_author)
    expect(test_book.authors).to eq [test_author]
    test_book.add_copies(1)
    expect(test_book.get_copies).to eq 2
  end

  it 'should allow the user to check out a copy of a book' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    test_author = Author.new({'name' => "Louisa May Alcott"})
    test_author.save
    test_patron = Patron.new({'name' => 'Dustin'})
    test_patron.save
    test_book.add_author(test_author)
    test_book.checkout(test_patron.id)
    expect(Book.get_checked_out).to eq [test_book]
  end

  it 'should provide a due date when the book is checked out' do
    test_book = Book.new({'name' => "Little Women"})
    test_book.save
    test_author = Author.new({'name' => "Louisa May Alcott"})
    test_author.save
    test_patron = Patron.new({'name' => 'Dustin'})
    test_patron.save
    test_book.add_author(test_author)
    test_book.checkout(test_patron.id)
    expect(test_patron.get_checked_out).to eq ({"Little Women" => '2014-08-20'})

  end
end
