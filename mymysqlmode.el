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




(defun mmsql-fdef(fname ftype null default unique &optional fromProgram)
  ""
  (interactive 
    "sfield name: \nsfield type: \nscan be NULL? (any key for 'no', blank for 'yes'): \nsdefault value: \nsunique? (any key for 'yes', blank for 'no'):"
  )
  
  (let
    (
      textStrings
    )
    (if(not (equal null ""))
      (progn
        (setq null " NOT NULL ")
      )
      (setq null " ")
    )    
    (if(not (equal default ""))
      (progn
        (setq default (concat "DEFAULT " default " "))
      )
    )      
    (if(not (equal unique ""))
      (progn
        (setq unique "UNIQUE")
      )
      (setq unique "")
    )       
    (setq textStrings ;предварительный список строк
      (list
        (concat
          fname
          " "
          ftype
          null     
          default
          unique
        )
      )
    )
    (mmsql-common-procedure-and-print textStrings)    
  )
)





(defun mmsql-ctb(temporary tbname)
  ""
  (interactive "stemporary? (any key for 'yes', blank for 'no'): \nstable name: ")
  
  (let
    (
      textStrings
    )
    (if(not (equal temporary ""))
      (progn
        (setq temporary " TEMPORARY ")
      )
      (setq temporary " ")
    )
    
    
    
    
    (setq textStrings ;предварительный список строк
      (list
        (concat "CREATE" temporary "TABLE IF NOT EXISTS " tbname)
        "("
        (concat (make-string tab-width ?\ ) "mmsql-fdef,")
        (concat (make-string tab-width ?\ ) "mmsql-fdef,")
        (concat (make-string tab-width ?\ ) "mmsql-tbopt")
        ")"
        (concat (make-string tab-width ?\ ) "mmsql-selst")
        ";"
      )
    )
    (mmsql-common-procedure-and-print textStrings)
    (previous-line 5)
    (back-to-indentation)
  )
)



(defun mmsql-dtb(tbname)
  ""
  (interactive "stable name: ")
  
  (let
    (
      
    )
    (setq textStrings ;предварительный список строк
      (list
        (concat "DROP TABLE IF EXISTS " tbname ";")
      )
    )
    (mmsql-common-procedure-and-print textStrings)    
  )
)




(defun mmsql-ins(tbname)
  ""
  (interactive "stable name: ")
  
  (let
    (
      
    )
    (setq textStrings ;предварительный список строк
      (list
        "INSERT INTO"
        (concat (make-string tab-width ?\ ) tbname "()")
        "VALUES"
        (concat (make-string tab-width ?\ ) "()")
        ";"
      )
    )
    (mmsql-common-procedure-and-print textStrings)
  )
)




)








