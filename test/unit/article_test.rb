require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should create article" do
    article = Article.new
    
    article.user = users(:eugene)
    article.title = "Test Article"
    article.body = "Test body"
    
    assert article.save
  end
end
