# Spending Tracker [![Codemagic build status](https://api.codemagic.io/apps/5dcdb8f05b37710008f462ef/5dcdb8f05b37710008f462ee/status_badge.svg)](https://codemagic.io/apps/5dcdb8f05b37710008f462ef/5dcdb8f05b37710008f462ee/latest_build)

## About

This app was built to help people keep track of their monthly spending. On the main screen, there is a top row of categories that the user creates to help them organize their transactions. The middle section of the screen contains the information about the current month and how much they spent that month. To the left and right of the month are chevrons to help users navigate between each month.

## Data Storage

There are currently two SQFLite database tables in this application.

### Category Table

This table contains the information about the categories that the user creates. This includes name, icon to represent the category, and two colors for displaying in the category page.

### Transactions Table

This table stores transaction that the user adds. This includes the name, description, amount, category, and date. The date is stored as an integer of milliseconds since epoch.

### Query

Querying of transactions can be filtered by using either the date represented as an integer or by category and date as an integer.

## TODO

- [ ] issue when spawning thread then changing mainthread page
- [ ] move add category and rearrange categories to settings page (high)
- [ ] back up storage options other than firebase (medium)
- [ ] add firebase functionality (for backup storage and data restore) (low)
- [ ] theme: ability to change colors (low)
- [ ] add animations (low)
- [ ] ability to set budget (low)

## Version History

### V0.9.3 (Dec 13, 2019)

- when pressing Add button, will auto fill in the Date and/or Category where possible
- set a forward and backward date limit
- adjusted error font size
- created analytics page
- increased icon size in CategoriesRow widget

### V0.9.2 (Nov 30, 2019)

- removed bouncing scroll on main screen
- fixed date render bug on categories view
- can rearrange categories
- updated categories database to version 2
- changed CategoryOverviewCard from square grid to listview widget

### V0.9.1 (Nov 22, 2019)

- changed which widgets will reloaded when notifyListener is called
- added snackbar confirmation when adding a transaction
- added a dialog window to quickly change month and year
- changed font to Quicksand

### V0.9.0 (Nov 17, 2019)

- first build candidate
- can add categories
- can add transactions
- can query transactions
- changed UI compared to Spending Tracker V1
- made creating monthly transaction object simpler
- added unit tests
