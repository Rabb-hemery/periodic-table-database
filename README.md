# periodic-table-database
A PostgreSQL database of chemical elements with a bash CLI script to query element info by atomic number, symbol, or name. Built for the freeCodeCamp Relational Database certification.
# Periodic Table Database

A relational database storing information about chemical elements, along with a command-line script to query it. Built as part of the [freeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn/relational-database/).

## Overview

The project uses PostgreSQL to store element data across three normalized tables:

- **elements** — atomic number, symbol, and name of each element
- **properties** — atomic mass, melting/boiling points (°C), and a foreign key to `types`
- **types** — the three element categories (metal, nonmetal, metalloid)

## Files

- `element.sh` — bash script to look up an element by atomic number, symbol, or name
- `periodic_table.sql` — SQL dump to rebuild the database

## Usage

Rebuild the database:

\`\`\`bash
psql -U postgres < periodic_table.sql
\`\`\`

Run the script:

```bash
./element.sh <atomic_number | symbol | name>
```

Examples:

```bash
./element.sh 1
# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

./element.sh Ne
# The element with atomic number 10 is Neon (Ne). It's a nonmetal, with a mass of 20.18 amu. Neon has a melting point of -248.6 celsius and a boiling point of -246.1 celsius.

./element.sh Nonexistent
# I could not find that element in the database.
```

## Tech

- PostgreSQL
- Bash

## Author

Project completed as part of freeCodeCamp's curriculum.
