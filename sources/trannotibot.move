module TranNotiBot::LockContract {
    use sui::object;
    use sui::tx_context;
    use sui::event;

    struct Key has key, store {
        id: object::ID,
    }

    struct Locked<T: key + store> has key, store {
        id: object::ID,
        key: object::ID,
    }

    struct LockCreated has copy, drop, store {
        lock_id: object::ID,
        key_id: object::ID,
        creator: address,
        item_id: object::ID,
    }

    public fun lock<T: key + store>(obj: T, ctx: &mut tx_context::TxContext): (Locked<T>, Key) {
        let key = Key { id: object::new(ctx) };
        let lock = Locked {
            id: object::new(ctx),
            key: key.id,
        };

        event::emit(LockCreated {
            lock_id: lock.id,
            key_id: key.id,
            creator: tx_context::sender(ctx),
            item_id: object::id(&obj),
        });

        (lock, key)
    }
}
