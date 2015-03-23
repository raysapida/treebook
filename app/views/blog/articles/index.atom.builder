atom_feed do |feed|
  feed.title("Exceptiontrap Blog")
  feed.updated(@articles[0].created_at) if @articles.length > 0

  @articles.each do |article|
    feed.entry(article, url: blog_article_url(article)) do |entry|
      entry.title(article.title)
      entry.content(markdown(article.content), type: 'html')
      entry.author do |author|
        author.name(article.author)
      end
    end
  end
end
