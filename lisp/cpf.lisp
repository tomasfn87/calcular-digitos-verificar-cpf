(defun reter-numeros (text n)
    (let (
        (only-nums "")
        (count 0))

    (loop for char across text
        when (digit-char-p char)
        do (progn
            (setq only-nums (concatenate 'string only-nums (string char)))
            (incf count)
            (when (= count n)
                (return))))

    (if (> count 0)
        (setq only-nums (format nil "~v,'0d" n (parse-integer only-nums))))

    only-nums))

(format t "reter-numeros \"test\"    1 -> \"~a\"~%"
    (reter-numeros "test" 1))
(format t "reter-numeros \"test123\" 2 -> \"~a\"~%"
    (reter-numeros "test123" 2))
(format t "reter-numeros \"test123\" 4 -> \"~a\"~%"
    (reter-numeros "test123" 4))
