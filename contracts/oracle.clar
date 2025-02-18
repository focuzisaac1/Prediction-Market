;; Oracle Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-unauthorized (err u102))

;; Data Maps
(define-map oracles principal bool)
(define-map verified-results
  { event-id: uint }
  { result: (string-ascii 100), timestamp: uint }
)

;; Public Functions

;; Add an oracle
(define-public (add-oracle (oracle principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ok (map-set oracles oracle true))
  )
)

;; Remove an oracle
(define-public (remove-oracle (oracle principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ok (map-delete oracles oracle))
  )
)

;; Submit a verified result
(define-public (submit-result (event-id uint) (result (string-ascii 100)))
  (begin
    (asserts! (default-to false (map-get? oracles tx-sender)) err-unauthorized)
    (map-set verified-results
      { event-id: event-id }
      { result: result, timestamp: block-height }
    )
    (try! (contract-call? .event set-event-result event-id result))
    (ok true)
  )
)

;; Read-only Functions

;; Check if an address is an oracle
(define-read-only (is-oracle (address principal))
  (default-to false (map-get? oracles address))
)

;; Get verified result for an event
(define-read-only (get-verified-result (event-id uint))
  (ok (unwrap! (map-get? verified-results { event-id: event-id }) err-not-found))
)

;; Initialize contract
(begin
  (map-set oracles contract-owner true)
)

