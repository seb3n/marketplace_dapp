# Brainstorming

Independent functional components

## Listing Service

- connects buyers & sellers by listing items
- calls the Exchange Service when buyers/sellers are realy to meetup and exchange goods

```argdown-map
# Listing Service

[Item]: items is an NFTs stored on IPFS
    _ <listItem>
    _ <unlistItem>
    _ <purchaseItem>: : buyer initiating purchase request calls the exchange service
      _ <ExchangeService>: exchange service takes over with buyer, seller, item params #con
```

## Exchange Service

- facilitates exchange of physical goods in a fair way

```argdown-map
# Exchange Service

[Exchange]: facilitate exchange between buyer, seller, terms, exchangeMethod (geolocMeetup or shipper)
  _ [confirmExchangeMethod]: coordinate via chat/vn and confirm exchange method
    _ <shippingService>
    _ <geolocMeetup>
      _ <both accept>: resolved
      _ <both reject>: resolved
      _ <one rejects>

## Shipping Service

<shippingService>: send job and terms to shipping service #con

## Resolution Service

<one rejects>: a dispute gets registered #con
```

## Transport Service

```argdown-map
# Transport Service

[Transport]: facilitate transport of goods given item, terms of transport
  - <transport job rejected>: expired jobs fall into this category #con
  + <transport job accepted>
    _ <exchangeService>

## Exchange Service

<exchangeService>: exchange of goods from shipper to buyer
```

## Resolution Service

- allows randomly selected `resolvers` to read disputes and stake/vote on resolution of an issue based on evidence provided and outcome desired

```argdown-map
# Resolution Service

[Resolve]: resolves disputes based on provided evidence
  _ <TODO>
```

## Full System Flowchart

The full system (marketplace) will have all four components

```argdown-map
# Marketplace

[ListingService]: connects buyers and sellers
    _ <ExchangeService>
    _ <TransportService>

## Exchange Service

<ExchangeService>: facilitates exchange of goods

<!-- <TransportService>: facilitates transfer of goods -->
```

Scenario flowgraph

```argdown-map
[ListingService has items]: Sal lists bananas on the *listing service* (eg. item.name = bananas, ...)
    - [Buyer makes PR]: Bob makes a PR for the bananas (eg. purchaseReq(bob, sally, bananas, exchange_terms) )
      - [(ExchangeService Initiated)]
        - [Funds moved to Escrow]: buyers funds are moved to an escrow  contract for holding
        - <Disagree on meetup terms>#con
          - Funds are returned to buyer.
        - <Agree on meetup terms>
          - [Meetup at geoloc]: Bob and Sal chat and agree to meet @time/place to exchange the goods
            - <Both Accept Exchange>: Bob takes a picture of item he received and accepts the items
              - [Funds are Transfered]: Sal get paid
            - <Both Reject Exchange>: Upon meeting Bob and Sal agree not to exchange
              - [Funds are Returned]: Bob gets refunded.
            - <One Rejects Exchange>:#con Both take pics/vids/etc and provides evidence and what they want (refund, etc)
              - [(Resolver Initiated)]: Claims get uploaded to a network of dispute mitigators.
                - [Resolver]: makes decisions based on evidence provided.
                  - <Approve dispute>
                    - [Funds returned to both parties]: less the compensation of the moderators
                  - <Decline dispute>#con
                    - [Funds proceed to Dispute initiator]: less the moderators fees. NOTE: if dispute is initiated against seller, there is no guarantee that they will relinquish items
                  - [Compensation]: Once network is done voting, the moderators are compensated or penalizex based on their contribution.
          - [Use a shipper]:  Contract between shipper and seller to deliver package.
            - <Disagree on shipping terms>#con
              - #loop cycle through shipping options
            - <Agree on shipping terms>: Both parties take evidence of transferered package.
              - [Transport to Buyer]: Both parties take pictures of package upon receipt.
                - buyer
```
