;; Betting Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-event-closed (err u102))
(define-constant err-insufficient-balance (err u103))

;; Data Variables
(define-data-var bet-nonce uint u0)

;; Data Maps
(define-map bets
  { bet-id: uint }
  {
    event-id: uint,
    bettor: principal,
    amount: uint,
    prediction: (string-ascii 100)
  }
)

(define-map event-odds
  { event-id: uint, outcome: (string-ascii 100) }
  { odds: uint }
)

(define-map event-total-bets
  { event-id: uint }
  { total: uint }
)

;; Public Functions

;; Place a bet
(define-public (place-bet (event-id uint) (amount uint) (prediction (string-ascii 100)))
  (let
    (
      (bet-id (var-get bet-nonce))
      (event (unwrap! (contract-call? .event get-event event-id) err-not-found))
      (current-total (default-to { total: u0 } (map-get? event-total-bets { event-id: event-id })))
    )
    (asserts! (is-eq (get status event) "upcoming") err-event-closed)
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    (map-set bets
      { bet-id: bet-id }
      {
        event-id: event-id,
        bettor: tx-sender,
        amount: amount,
        prediction: prediction
      }
    )
    (map-set event-total-bets
      { event-id: event-id }
      { total: (+ (get total current-total) amount) }
    )
    (var-set bet-nonce (+ bet-id u1))
    (ok bet-id)
  )
)

;; Update odds for an event outcome
(define-public (update-odds (event-id uint) (outcome (string-ascii 100)) (new-odds uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ok (map-set event-odds { event-id: event-id, outcome: outcome } { odds: new-odds }))
  )
)

;; Read-only Functions

;; Get bet details
(define-read-only (get-bet (bet-id uint))
  (ok (unwrap! (map-get? bets { bet-id: bet-id }) err-not-found))
)

;; Get odds for an event outcome
(define-read-only (get-odds (event-id uint) (outcome (string-ascii 100)))
  (ok (unwrap! (map-get? event-odds { event-id: event-id, outcome: outcome }) err-not-found))
)

;; Get total bets for an event
(define-read-only (get-total-bets (event-id uint))
  (ok (unwrap! (map-get? event-total-bets { event-id: event-id }) err-not-found))
)

;; Initialize contract
(begin
  (var-set bet-nonce u0)
)

