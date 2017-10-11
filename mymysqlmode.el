(progn
(defun mmsql-common-procedure-and-print(textStrings)
  ""
  (let
    (
      offset      
    )
    (setq offset (make-string (current-column) ?\ ))
    (setq textStrings ;добавляем отступ ко всем строкам, кроме первой
      (cons 
        (car textStrings)
        (mapcar
          (lambda (string)
            (concat offset string)
          )
          (cdr textStrings)
        )
      )
    )
    (princ ;выводим результирующий текст
      (mapconcat ;соединяем все строки в текст
        (lambda (string)
          string
        )
        textStrings
        "\n"
      ) 
      (current-buffer)
    )   
  )
)




(defun mmsql-cdb(dbname charset collate)
  ""
  (interactive "sdatabase name :\nscharacter set: \nscollate :")
  
  (let
    (
      textStrings
    )
    (if(equal dbname "")
      (progn
        (setq dbname "unnamed")
      )      
    )
    (if(equal charset "")
      (progn
        (setq charset "utf8")
      )
    )
    (if(equal collate "")
      (progn
        (setq collate "utf8_general_ci")
      )
    )
    (setq textStrings ;предварительный список строк
      (list
        (concat "CREATE DATABASE IF NOT EXISTS " dbname " CHARACTER SET " charset " COLLATE " collate ";") 
      )
    )
    (mmsql-common-procedure-and-print textStrings)    
  )
)



(defun mmsql-ddb(dbname)
  ""
  (interactive "sdatabase name: ")
  
  (let
    (
      
    )
    (setq textStrings ;предварительный список строк
      (list
        (concat "DROP DATABASE IF EXISTS " dbname ";") 
      )
    )
    (mmsql-common-procedure-and-print textStrings)     
  )
)







(defun mmsql-ctb(temporary tbname)
  ""
  (interactive "stemporary? (any key for 'yes', blank for 'no') \nstable name: ")
  
  (let
    (
      
    )
    (if(not (equal temporary ""))
      (progn
        (setq temporary "TEMPORARY")
      )
    )
    (setq textStrings ;предварительный список строк
      (list
        (concat "CREATE " temporary " TABLE IF NOT EXISTS " tbname)
        
      )
    )
    (mmsql-common-procedure-and-print textStrings)      
  )
)









)








