#!/bin/bash
# Yo buddy this is Rewrite here :)
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
# if...
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER_OR_SYMBOL_OR_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
 
  else
    ATOMIC_NUMBER_OR_SYMBOL_OR_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1' OR symbol='$1'")
  fi

  if [[ -z $ATOMIC_NUMBER_OR_SYMBOL_OR_NAME ]]
  then
    echo "I could not find that element in the database."
  else
    INFO=$($PSQL "SELECT elements.atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number=$ATOMIC_NUMBER_OR_SYMBOL_OR_NAME")

    ATOMIC_NUMBER=$(echo $INFO | cut -d '|' -f 1 | sed 's/ //g')
    SYMBOL=$(echo $INFO | cut -d '|' -f 2 | sed 's/ //g')
    NAME=$(echo $INFO | cut -d '|' -f 3 | sed 's/ //g')
    TYPE=$(echo $INFO | cut -d '|' -f 4 | sed 's/ //g')
    MASS=$(echo $INFO | cut -d '|' -f 5 | sed 's/ //g')
    MELTING_POINT=$(echo $INFO | cut -d '|' -f 6 | sed 's/ //g')
    BOILING_POINT=$(echo $INFO | cut -d '|' -f 7 | sed 's/ //g')

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi
