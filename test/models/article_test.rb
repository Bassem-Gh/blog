require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'draft? returns true for draft articles' do
    assert Article.new(published_at: nil).draft?
  end

  test 'draft? returns false for draft articles' do
    refute Article.new(published_at: 1.day.ago).draft?
  end
  test 'published? returns false  for scheduled blog articles' do
    refute Article.new(published_at: 1.year.from_now).published?
  end
  test 'archived? returns true for archived articles' do
    assert Article.new(status: 'archived').archived?
  end
end
