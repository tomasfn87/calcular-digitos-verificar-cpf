(defun main ()
    (let (
        (args sb-ext:*posix-argv*))

    (if (< (length args) 2)
        (progn
            (print-help)
            (return-from main nil)))
    
    (if (string= (nth 1 args) "--demo")
        (progn
            (format t "         verificar \"19372\" -> ~a~%"
                (verificar "19372"))
            (format t "         verificar \"19293\" -> ~a~%"
                (verificar "19293"))
            (format t "          verificar \"test\" -> ~a~%~%"
                (verificar "test"))

            (format t "    calcular-digitos \"123\" -> ~a~%"
                (calcular-digitos "123"))
            (format t "    calcular-digitos \"193\" -> ~a~%"
                (calcular-digitos "193"))
            (format t "   calcular-digitos \"test\" -> ~a~%~%"
                (calcular-digitos "test"))

            (format t "reter-numeros \"test\"    1  -> \"~a\"~%"
                (reter-numeros "test" 1))
            (format t "reter-numeros \"test123\" 2  -> \"~a\"~%"
                (reter-numeros "test123" 2))
            (format t "reter-numeros \"test123\" 4  -> \"~a\"~%"
                (reter-numeros "test123" 4))
            
            (return-from main nil)))
    
    (if (< (length args) 3)
        (progn
            (print-help)
            (return-from main nil)))
    
    (if (= (length (reter-numeros (nth 2 args) 1)) 0)
        (progn
            (print-help)
            (return-from main nil)))
    
    (if (or 
        (string= (nth 1 args) "--calcular")
        (string= (nth 1 args) "-c"))
            (progn 
                (format t "~a~%" (calcular-digitos (nth 2 args)))
                (return-from main nil)))

    (if (or 
        (string= (nth 1 args) "--verificar")
        (string= (nth 1 args) "-v"))
        (progn
            (format t "O CPF é ")
            (if (null (verificar (nth 2 args)))
                (format t "in"))
            (format t "válido.~%")))))

(defun print-help ()
    (format t "Digite uma das opções abaixo: ~%")
    (format t " * '-c' ou '--calcular' e um número de CPF;~%")
    (format t " * '-v' ou '--verificar' e um número de CPF.~%"))

(defun verificar (cpf)
    (let (
        (nums-cpf "")
        (dvs-recebidos (list 0 0))
        (dvs-calculados (list 0 0)))

    (setq nums-cpf (reter-numeros cpf 11))
    (if (= (length nums-cpf) 0)
         (return-from verificar ""))
    
    (setf (nth 0 dvs-recebidos) (parse-integer (string (schar nums-cpf 9))))
    (setf (nth 1 dvs-recebidos) (parse-integer (string (schar nums-cpf 10))))

    (setq nums-cpf (subseq nums-cpf 0 9))
    (setf dvs-calculados (calcular-digitos nums-cpf))
    
    (if (loop for i from 0 to 1
        always (= (nth i dvs-calculados) (nth i dvs-recebidos)))
        (return-from verificar t))

    nil))

(defun calcular-digitos (cpf)
    (let (
        (temp 0)
        (nums-cpf "")
        (resultado (list 0 0)))

    (setq nums-cpf (reter-numeros cpf 9))
    (if (= (length nums-cpf) 0)
         (return-from calcular-digitos ""))

    (setq temp (calcular-digito-verificador nums-cpf))
    (setf (nth 0 resultado) temp)

    (setq nums-cpf (format nil "~a~a" nums-cpf temp))

    (setq temp (calcular-digito-verificador nums-cpf))
    (setf (nth 1 resultado) temp)

    resultado))

(defun reter-numeros (text n)
    (let (
        (only-nums "")
        (count 0))

    (loop for char across text
        when (digit-char-p char)
        do (progn
            (setq only-nums (format nil "~a~c" only-nums char))
            (incf count)
            (when (= count n)
                (return))))

    (if (> count 0)
        (setq only-nums (format nil "~v,'0d" n (parse-integer only-nums))))

    only-nums))

(defun calcular-digito-verificador (digitos)
    (let (
        (remainder 0)
        (factor 0)
        (sum 0))

    (setq factor (1+ (length digitos)))

    (loop for char across digitos
         do (progn
            (setq sum (+ sum (* factor (parse-integer (string char)))))
            (decf factor)))
    
    (setq remainder (mod sum 11))
    
    (if (> remainder 1)
        (return-from calcular-digito-verificador (- 11 remainder)))

    0))

(main)