;; Event Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))

;; Data Variables
(define-data-var event-nonce uint u0)

;; Data Maps
(define-map events
  { event-id: uint }
  {
    name: (string-ascii 100),
    description: (string-utf8 500),
    start-time: uint,
    end-time: uint,
    status: (string-ascii 20),
    result: (optional (string-ascii 100))
  }
)

;; Public Functions

;; Create a new sports event
(define-public (create-event (name (string-ascii 100)) (description (string-utf8 500)) (start-time uint) (end-time uint))
  (let
    (
      (event-id (var-get event-nonce))
    )
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (is-none (map-get? events { event-id: event-id })) err-already-exists)
    (map-set events
      { event-id: event-id }
      {
        name: name,
        description: description,
        start-time: start-time,
        end-time: end-time,
        status: "upcoming",
        result: none
      }
    )
    (var-set event-nonce (+ event-id u1))
    (ok event-id)
  )
)

;; Update event status
(define-public (update-event-status (event-id uint) (new-status (string-ascii 20)))
  (let
    (
      (event (unwrap! (map-get? events { event-id: event-id }) err-not-found))
    )
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ok (map-set events
      { event-id: event-id }
      (merge event { status: new-status })
    ))
  )
)

;; Set event result
(define-public (set-event-result (event-id uint) (result (string-ascii 100)))
  (let
    (
      (event (unwrap! (map-get? events { event-id: event-id }) err-not-found))
    )
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ok (map-set events
      { event-id: event-id }
      (merge event { result: (some result), status: "completed" })
    ))
  )
)

;; Read-only Functions

;; Get event details
(define-read-only (get-event (event-id uint))
  (ok (unwrap! (map-get? events { event-id: event-id }) err-not-found))
)

;; Initialize contract
(begin
  (var-set event-nonce u0)
)

