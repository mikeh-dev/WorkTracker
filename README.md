### Work Order App
This is a simple application (for now) to manage work orders for a vehicle conversion business.

# Three main goals for this app:
- Manage work orders and delegate to production team

- Manage vehicle images to give the business some digital history of the vehicles they've worked on, the condition they were in on arrival, and the condition they were in on delivery.

- Give the customer and other teams members a place to track the progress of work orders.

# Eventually, I'd like to add a few more features:
- Notifications for Production Team when a new work order is created or updated.
- Notifications for Customer when a work order is updated or completed.
- A calendar to help with scheduling for production team.
- Google Calendar integration to sync with the business's calendar.
- API Integration with Business Software to sync work orders with Sales Ordes and Production Jobs

### Tech Stack
- Ruby on Rails with Hotwire
- TailwindCSS - Shout out to @justalever for RailsUI FrontEnd Starter Kit
- TDD with RSpec
- PostgreSQL
- Devise for Authentication

## New Stuff I've Learnt
Biggest thing I'm happy with on this one is the Image handling on the Work Order form.

I used a Stimulus controller to handle the image preview after upload and also used a modal controller which came in Rails UI to handle displaying a larger image when needed.

I also wrote a remove image method that will remove the image from the database when the user clicks the remove button in form.

I also used the RailsUI form builder to quickly create a nice looking form.