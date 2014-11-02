(in-package algorithm)

(defun counting-sort (seq max-num)
  (let* ((len (length seq))
         (tmp (make-array (1+ max-num) :initial-element 0))
         (result (make-array len :initial-element 0)))
    (dotimes (i len) (incf (aref tmp (aref seq i))))
    (dotimes (i max-num) (incf (aref tmp (1+ i)) (aref tmp i)))
    (dotimes (i len)
      (setf (aref result (1- (aref tmp (aref seq i)))) (aref seq i))
      (decf (aref tmp (aref seq i))))
    result))

