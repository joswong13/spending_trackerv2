# Spending Tracker

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

## TODO (not in order of importance)

- [ ] back up storage options other than firebase
- [ ] add firebase functionality (for backup storage and data restore)
- [ ] theme: ability to change colors
- [ ] quick select months
- [ ] quick reset to current month

## Version History

### V0.0.9 (Nov 17, 2019)

- can add categories
- can add transactions
- can query transactions
- changed UI compared to Spending Tracker V1
- made creating monthly transaction object simpler
- have unit tests
