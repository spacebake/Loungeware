/* if anyone tries to use global vars in their microgame a macro override will cause
the var to be assigned to this object instead. this object is destroyed and recreated 
at the end of each microgame, clearing all the variables */