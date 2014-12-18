<h1>Small-Time Grocer</h1>

<p>Small-Time Grocer is an organizational tool for small grocery store owners and convenience store owners. In its current state it can track vendors, items, deals and purchases.</p>

Technologies used:
- Ruby 2.1.2
- Sinatra
- PostgreSQL database
- CSS
- Active Record

A user can:
- signup/login
- create vendors
- create items
- create and update deals with prices
- create purchases based off of deals
- search deals available by vendor or item
- view purchases

<h2>Getting Started</h2>

1. Install development environment in the root directory where app.rb lives in<br>
 <code>bundle install</code>

2. Create database <br>
 <code>rake db:create</code><br>
 <code>rake db:migrate</code>

3. Run application in the root directory where app.rb lives in <br>
 <code>ruby app.rb</code>

4. Open up browser and enter:<br>
 <code>localhost:4567</code>

<h3> And you're in! </h3>

This website is currently deployed at <link>https://warm-tor-1487.herokuapp.com/</link>

User Stories can be found at <link>https://www.pivotaltracker.com/n/projects/1230064</link>

ERD's can be found at <link>http://www.gliffy.com/go/publish/6824695</link>

<h4>Going Forward!</h4>
<p> I hope to create more functionality. I want to incorporate dates of purchases and the ability to track inventories eventually as well. Might have to deal with some issues in terms of scalability going forward. Any and all suggestions are super helpful. Thanks </p>
