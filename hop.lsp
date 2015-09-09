(defun c:BreakIt (/ Ent1 Ent1E EntSS MkArc ct IntLst ct2 pt1 pt1a bptlist BDis ct3) (vl-load-com)
	(if (not (setq BDis (getreal "Enter a gap/hop distance <200>: ")))
 		(setq BDis 200)
 	)
 
	(if (or (/= (getvar "cvport") 1) (/= (getvar "tilemode") 0))
		(setq BDis (/ BDis (getvar "cannoscalevalue"))) 
	)
 
	(princ "\n")
 
	(while (= Ent1 nil)
		(setq Ent1 (entsel "\rSelect the line to break: ")) 
	)
 
	(setq Ent1E (vlax-ename->vla-object (car Ent1)))
 
	(princ "\n")
 
	(while (= EntSS nil)
 		(princ "\rSelect the line to hop over: ")
		(setq EntSS (ssget))
	)

	(setq ct 0)
 
	(while (< ct (sslength EntSS))
 		
 		(setq intLst (vlax-invoke Ent1E 'intersectWith (vlax-ename->vla-object (ssname EntSS ct)) acExtendNone))
		
		(cond
 			((/= intLst nil)
 				
 				(setq ct2 0)
				
				(while (< ct2 (length intLst))
					
					(setq pt1 (list (nth ct2 intLst) (nth (+ ct2 1) intLst) (nth (+ ct2 2) intLst)))
					
					(setq pt1a (vlax-curve-getdistatparam Ent1E (vlax-curve-getparamatpoint Ent1E pt1)))
 					
 					(cond
 						((= bptlist nil)
							(setq bptlist (list (vlax-curve-getpointatdist Ent1E (- pt1a BDis))))
						)
						
						(T
 							(setq bptlist (append bptlist (list (vlax-curve-getpointatdist Ent1E (- pt1a BDis)))))
						)
					)
 					
 					(setq bptlist (append bptlist (list (vlax-curve-getpointatdist Ent1E (+ pt1a BDis)))))
					
					(setq ct2 (+ ct2 3))
 				)
			)
		)
 		(setq ct (+ ct 1))
 	)

	(cond
		((/= bptlist nil)
 			
 			(setq ct3 0)
 			
 			(while (< ct3 (length bptlist))
 				
 				(command "._break" "_non" (trans (nth ct3 bptlist) 0 1) "_non" (trans (nth (+ ct3 1) bptlist) 0 1))
				
				(setq ct3 (+ ct3 2))
 			)
 		)
	)

	(princ "\n")
	(princ "\nCreate hop: ")
	(princ "\n")
	
	(while (= MkArc nil)
		(command "arc")
	)

)

(princ
  (strcat
    "\n--> Hop Loaded."
    "\n--> Type command \"hop\" to run program."
    "\n"
  )
)

(defun C:hop ()
	(c:breakit) 
)
