(in-package algorithm)

(defun quick-partition (lst beg end)
  (let ((i (1- beg)) (judge-elt (nth end lst)))
    (do ((j beg (1+ j))) ((= j end))
      (when (<= (nth j lst) judge-elt)
        (setf i (1+ i))
        (rotatef (nth i lst) (nth j lst))))
    (rotatef (nth (1+ i) lst) (nth end lst))
    (1+ i)))

(defun quick-sort (lst beg end)
  (when (< beg end)
    (let ((i (quick-partition lst beg end)))
      (quick-sort lst beg (1- i))
      (quick-sort lst (1+ i) end))))
