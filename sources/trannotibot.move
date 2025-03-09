use sui::event;

public fun lock<T: key + store>(obj: T, ctx: &mut TxContext): (Locked<T>, Key) {
    let key = Key { id: object::new(ctx) };
    let mut lock = Locked {
        id: object::new(ctx),
        key: object::id(&key),
    };
    event::emit(LockCreated {
        lock_id: object::id(&lock),
        key_id: object::id(&key),
        creator: ctx.sender(),
        item_id: object::id(&obj),
    });
    dof::add(&mut lock.id, LockedObjectKey {}, obj);
    (lock, key)
}