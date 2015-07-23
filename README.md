## Sidekiq Link Check

You are going to use sidekiq and redis to create an application that checks if the links on a page are all good links (not broken).

__Reqiurements:__

* Create a form page that allows the user to save a site.
    * A site has many links
* A site should be saved to the database, the site should then use nokogiri to get all links on the page.
* Use typhoeus to make a HTTP get request each link on the page.
    * Some links on the page may be relative paths.  You'll have to add the domain to the relative path
* Display all the links in a show page for the site.  The link should have the http status code.  Display the status code in green if it is less than 400, and red if it is greater than or equal to 400.
* Write the nokogiri and typhoeus code in a sidekiq worker (only do this after you have the slow version working without sidekiq)

__Algorithm__

Here is a pseduo code algorithm of what you'll be writing to check the links:

```
Get the parameter for the url to check
Create a site record in the database (Save the url)
Use Nokogiri to get the page and parse the contents
Use Nokogiri to get all anchor tags
For each anchor tag, do:
   Get the href from the anchor tag
   Make sure the href starts with http, https or is a relative path
   Use Typhoeus to get the linked page
   Create a new recored in the DB for the link (Saves link url, and http response code)
end

redirect to the show page for the site
```

The Nokogiri code and the loop should be moved to a worker.


## Bonus

* Write a mailer to email the user the status of all of the links on the page once the worker for the links is done.  Put the mailer in a separate worker.


