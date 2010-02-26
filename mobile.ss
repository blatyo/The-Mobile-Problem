;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname mobiles) (read-case-sensitive #t) (teachpacks ((lib "testing.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "testing.ss" "teachpack" "htdp")))))
;
; $Author: Allen Madsen $
;
; description: 
; Mobiles
;
; restrictions: you must use only the basic operations of scheme,
;     which includes cond, cons, car and cdr.
;     you may not use length, apply, map, or any other higher level functions.
;
; you are encouraged to write helper functions as appropriate.
; Be sure you document them clearly and consistently.
;
; here is how you execute these exercises with Dr Scheme:
;   start drscheme
;   select language:
;     How To Design Programs advanced student and
;       testing.ss teachpack, which includes the check-expect function.
;     open the file mobiles.ss
;     tell drscheme to run
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;cord type describes the child, which may be either a strut or ball
(define-struct cord (height type child))
;left and right are strut parts
(define-struct strut (left right))
;child is a cord
(define-struct strut-part (width child))
(define-struct ball (weight))

(define (total-height mobile)
  (cond
    ;if child is strut
    ((eq? (cord-type mobile) 'strut)
     ;get the left height
     (let ((l-height 
            (total-height 
              (strut-part-child 
               (strut-left 
                (cord-child mobile))))))
       ;and the right height
       (let ((r-height 
         (total-height 
           (strut-part-child 
             (strut-right 
               (cord-child mobile))))))
         ;add this cords height
         (+ (cord-height mobile)
           ;plus the larger of the left and right heights
           (cond 
             ((< l-height r-height) r-height)
             (#t l-height)
           )))))
    ;otherwise, if child is a ball, return this chords height
    (#t (cord-height mobile)))
)

(define (total-weight mobile)
  (cond
    ;if ball is attached to cord
    ((eq? (cord-type mobile) 'ball)
      ;return ball weight
      (ball-weight (cord-child mobile)))
    ;otherwise, if a strut
    (#t (+ 
         ;add left weight
         (total-weight 
          (strut-part-child 
           (strut-left 
            (cord-child mobile))))
         ;plus right weight
         (total-weight 
          (strut-part-child 
           (strut-right 
            (cord-child mobile)))))))
)

(define (is-balanced mobile)
  (cond
    ;if ball is on cord, mobile is balanced
    ((eq? (cord-type mobile) 'ball) #t)
    ;if strut is on cord check that
    ((and
      ;left is ballanced
      (is-balanced (strut-part-child (strut-left (cord-child mobile))))
      ;right is ballanced
      (is-balanced (strut-part-child (strut-right (cord-child mobile))))
      (= 
       (* 
        ;width of left strut part
        (strut-part-width (strut-left (cord-child mobile)))
        ;times total weight of left
        (total-weight (strut-part-child (strut-left (cord-child mobile))))) 
       ;equals
       (* 
        ;width of right strut part
        (strut-part-width (strut-right (cord-child mobile)))
        ;times total weight of right
        (total-weight (strut-part-child (strut-right (cord-child mobile)))))))
     #t)
    ;otherwise, it is unbalanced
    (#t #f)
  )
)

;samle given
(define sample 
  (make-cord 2 'strut 
    (make-strut 
      (make-strut-part 20 
        (make-cord 1 'strut 
          (make-strut
            (make-strut-part 5 
              (make-cord 1 'ball 
                (make-ball 5)))
            (make-strut-part 5
              (make-cord 1 'strut 
                (make-strut
                  (make-strut-part 4
                    (make-cord 5 'ball 
                      (make-ball 3)))
                  (make-strut-part 6
                    (make-cord 1 'ball 
                      (make-ball 2)))))))))
      (make-strut-part 10 
        (make-cord 5 'ball
          (make-ball 20))))))

;cord and ball
(define cord-and-ball
  (make-cord 11 'ball
    (make-ball 20)))

;unbalanced
(define unbalanced
  (make-cord 4 'strut
    (make-strut
      (make-strut-part 4 cord-and-ball)
      (make-strut-part 11 cord-and-ball))))

;test sample given
(check-expect (is-balanced sample) #t)
(check-expect (total-weight sample) 30)
(check-expect (total-height sample) 9)

;test cord and ball
(check-expect (is-balanced cord-and-ball) #t)
(check-expect (total-weight cord-and-ball) 20)
(check-expect (total-height cord-and-ball) 11)

;test unbalanced
(check-expect (is-balanced unbalanced) #f)
(check-expect (total-weight unbalanced) 40)
(check-expect (total-height unbalanced) 15)