#!/bin/bash

HP=60
HP_max=60
HP_half=30
STR=10
HP_boko=30
HP_ganon=150
STR_boko=5
let STRp_boko=STR_boko*0,5
let STRp_ganon=STR_ganon*0,5
STR_ganon=20
choice=0
num_floor=1


function new_game(){
  echo "Welcome to the Game !"
  echo "1.New Game     2.Quit"
  read new_game_choice
  if (("$new_game_choice==2"));then
    echo "You leaved the game, Goodbye!"
    exit;
  fi
}
function read_choice(){ 
  echo "------------OPTIONS-----------"
  echo "1.Attack    2.Heal    3.Escape"
  read choice
}

function Attack_hero(){
  if (("$HP"> 0)) && (("$HP_boko>0"));then
    HP=`echo "$HP-$STR_boko" | bc`
    echo "The ennemy attacked and dealt $STR_boko damages!"
  fi
}

function heal(){ 
if (("$HP"> 0));then
  if (("$HP" == "$HP_max"));then
    HP=$HP_max
    echo "you are already full HP, you have $HP HP"
  elif (("$HP <=$HP_half"));then
    HP=`echo "$HP+$HP_half" | bc`
    echo "you healed yourself, you have $HP"
  else
    HP=$HP_max
    echo "You have $HP HP"
  fi
fi
}
function Attack_bolkoblin(){ 
  if (("$HP"> 0)) && (("$HP_boko>0"));then
    HP_boko=`echo "$HP_boko-$STR" | bc`
    echo "You attacked and dealt $STR damages! The ennemy has $HP_boko left!"
  fi
}
function Attack_ganon(){ 
  if (("$HP"> 0)) && (("$HP_ganon>0"));then
    HP_ganon=`echo "$HP_ganon-$STR" | bc`
    echo "you attack ganon, he has $HP_ganon left"
  fi
}
function Attack_hero_g(){ 
  if (("$HP"> 0)) && (("$HP_ganon>0"));then
    HP=`echo "$HP-$STR_ganon" | bc`
    echo "The boss attacked and dealt $STR_ganon damages!"
  fi
}
function Floor_10(){ 
  HP=$HP_max
  while true ; do
    read_choice
    if (($choice==2));then
      heal
      Attack_hero_g
      echo "$HP"
    elif (($choice==1));then
      Attack_ganon
      Attack_hero_g
      echo "$HP"
      if (($HP_ganon<=0));then
        echo "Congrats you win THE GAME"
        exit;
      elif (($HP==0));then
        echo "GAME OVER!!"
        exit;
      fi
    elif (($choice==3));then
      exit;
    fi
done
}

function Floor(){ 
  new_game
  while true ; do
    read_choice
    elif (($choice==2));then
      heal
      Attack_hero
      echo "$HP"
    elif (($choice==1));then
      Attack_bolkoblin
      Attack_hero
      echo "$HP"
      if (($HP_boko<=0));then
        echo "Congrats you win"
        num_floor=$(($num_floor+1))
        echo "welcome to $num_floor'th floor"
        HP_boko=30
        if (("$num_floor==10"));then
          Floor_10
        fi
      elif (($HP==0));then
        echo "GAME OVER!!"
        exit;
      fi
    elif (($choice==3));then
      exit;
    fi
done
}


while (("$num_floor<10"));do 
  if (($HP!= 0)) ;then
    Floor
  fi
done