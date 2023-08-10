
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align --tuples-only -c"
ELEMENT=$1

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ ! $ELEMENT =~ ^[0-9]+$ ]]
  then
    READ_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol ILIKE '$ELEMENT' OR name ILIKE '$ELEMENT'")
    #check if the element is not empty
    if [[ -z $READ_ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$READ_ELEMENT" | while IFS='|' read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
      do
        echo  "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  else
    READ_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = '$ELEMENT'")
    #check if the element is not empty
    if [[ -z $READ_ELEMENT ]]
    then
      echo"I could not find that element in the database."
    else
      echo "$READ_ELEMENT" | while IFS='|' read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
      do
      echo  "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  fi
fi
