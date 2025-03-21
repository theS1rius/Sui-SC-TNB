module TranNotiBot::TransactionListener {
    use sui::event;
    use sui::tx_context;
    use std::debug;

    /// 定義自訂事件結構
    public struct TransactionEvent has copy, drop {
        sender: address,
        amount: u64,
        timestamp: u64,
    }

    /// 發送交易事件
    public fun emit_transaction_event(sender: address, amount: u64, ctx: &mut TxContext) {
        let event = TransactionEvent {
            sender,
            amount,
            timestamp: 0,
        };
        event::emit(event);
        debug::print(&event); // 打印事件資訊到本地控制台
    }

    /// 測試函數：模擬交易並觸發事件
    public fun simulate_transaction(ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        let amount = 100; // 模擬的交易金額
        emit_transaction_event(sender, amount, ctx);
    }
}