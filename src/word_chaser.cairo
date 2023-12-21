#[starknet::interface]
trait wordchaserTrait<TContractState> {
    fn create_unknown_word(self:@TContractState, example:felt252, meaning:felt252, word:felt252);
    fn get_letters(ref self:@TContractState, key:u128) -> Array<Letter>;
    fn display_progress(ref self:@TContractState, key:u128) -> Letter;
}

#[starknet::contract]
mod WordChaser {
    use core::array::ArrayTrait;
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use core::debug::PrintTrait;

    #[storage]
    struct Storage {
        completed: LegacyMap<CompletedWord>, 
        letters: LegacyMap<Letter>,
        vocabulary: LegacyMap<u128, Vocabulary>
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Info {
        info: felt252,
        description: felt252,
        method: felt252
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Vocabulary {
        example: felt252,
        meaning: felt252,
        word: felt252
    }

    #[derive(Drop)]
    enum Status {
        Completed,
        Inprogress,
        Failed,
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Letter {
        letter: felt252,
        is_revealed: bool
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct CompletedWord {
        word: felt252,
        status: felt252,
        trials_completed_at: felt252,
        completed_at: felt252
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Player {
        userid: felt252,
        guess: felt252,
        word_progress: felt252,
        turns: u128,
        is_revealed: bool
    }

    #[external(v0)]
    impl wordchaserImpl of wordchaserTrait<ContractState> {
        fn create_unknown_word(self:@TContractState, example:felt252, meaning:felt252, word:felt252) {
            
        }
    }
}