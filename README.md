# Conditional narrowing
This implementation is related to a paper: https://link.springer.com/chapter/10.1007/978-3-031-17244-1_2.

Maude currently supports many symbolic reasoning features such as order-sorted equational unification and order-sorted narrowing-based symbolic reachability analysis. There have been many advances and new features added to improve narrowing in Maude but only at a theoretical level. In this paper, we provide a very elegant, transparent, and extremely pragmatic approach for conditional rewrite theories where the conditions are just equalities solved by equational unification. We show how two conditional theories, never executed before, are now executable with very good performance. We also show how real execution works better than the manually transformed version.


## Requisites
In order to run the files, Maude version 3.2.1 is required, which can be found in http://maude.cs.illinois.edu/w/index.php/The_Maude_System.

## Repository structure
###### root folder
Two files are located at the root of the project. One of them is the canonical narrowing of a previous paper. The other is the algorithm extended to support theories with conditional rules of type equality.

###### bank-account
This folder contains an example for using conditional narrowing. It is the model of a bank account.

###### ft-channel
This folder contains another example for using conditional narrowing. It is the model of a communication channel.

## Algorithm execution
The first step in running the algorithms is to run Maude. Once this is done, it is necessary to load the modules that are in the files in the root of the project. To do this, the "load [file]" command is used. It is also necessary to load the file containing the rewrite theory to be used. In our case, these files are located in "bank-account" and "ft-channel" folders, but the user can specify any other. Finally, the call to the algorithm must be executed as follows:

```
reduce in NARROWING :
        narrowing(upModule(<module_name>, false),
              <initial_term>,
              =>*,
              <target_term>,
              <narrowing_type>, <variant_option_set>, <irreducibility_constrainst>,
              <variable_qid>, <maximum_depth>, <maximum_solutions>) .
``` 

Where the parameters that are between "<" and ">" are at the user's choice. The options are as follows:
* module_name: Name of the module that defines the rewrite theory to use.
* initial_term: Initial term for narrowing.
* target_term: Target term for narrowing.
* narrowing_type: It can be "standard" or "canonical". In the second case, irreducibility constraints will be used to eliminate unnecessary narrowing steps. If we also add "smt" at the beginning of any of the two, we will indicate that a conditional module with SMT restrictions is used.
* variant_option_set: It can be "filter" or "none" (review Maude's original command). The first case only works correctly for standard narrowing.
* irreducibility_constrainst: Takes the value of the list of initial irreducibility constraints. It can be empty. In fact, if standard narrowing is used, it will be ignored even if it is given another value.
* variable_qid: This parameter is important if an identifier is used for variables in the start and/or target terms that is '@, '#, or '%. It must be indicated in it which of them is used. In case none are used, choose any of them for this parameter.
* maximum_depth: Maximum depth that you want to deploy the search tree for narrowing.
* maximum_solutions: Maximum solutions that you want the narrowing algorithm to find.

### Running example
Now we give an example of use if, for example, we want to execute a reachability problem using the bank account rewrite theory. The first thing, after executing Maude, is to load the necessary modules for it. Let's imagine that we are at the root of this project:

```
load conditional-narrowing.maude
load bank-account/bank-account.maude
```

Now we can run a problem. For example, we will use the reachability problem 
< bal: 1 + 1 + 1 + 1 pend: Pend1:Natural  overdraft: Over1:Bool > # Msgs1:MsgConf
=>* 
< bal: Bal2:Natural pend: Pend2:Natural  overdraft: Over2:Bool > # Msgs2:MsgConf.
If we want to execute both standard and canonical narrowing:

```
mod TEST-PROTOCOL is
  protecting NARROWING .
  protecting BANK-ACCOUNT .
endm

reduce in TEST-PROTOCOL :
        narrowing(upModule('BANK-ACCOUNT, false),
              --- INITIAL TERM
              upTerm(
                < bal: 1 + 1 + 1 + 1 pend: Pend1:Natural  overdraft: Over1:Bool > # Msgs1:MsgConf
              ),  
              =>*,
              upTerm(
                < bal: Bal2:Natural pend: Pend2:Natural  overdraft: Over2:Bool > # Msgs2:MsgConf
              ),
              standard, none, empty, '@, 2, unbounded) .

mod TEST-PROTOCOL is
  protecting NARROWING .
  protecting BANK-ACCOUNT .
endm

reduce in TEST-PROTOCOL :
        narrowing(upModule('BANK-ACCOUNT, false),
              --- INITIAL TERM
              upTerm(
                < bal: 1 + 1 + 1 + 1 pend: Pend1:Natural  overdraft: Over1:Bool > # Msgs1:MsgConf
              ),  
              =>*,
              upTerm(
                < bal: Bal2:Natural pend: Pend2:Natural  overdraft: Over2:Bool > # Msgs2:MsgConf
              ),
              canonical, none, empty, '@, 2, unbounded) .         
```
