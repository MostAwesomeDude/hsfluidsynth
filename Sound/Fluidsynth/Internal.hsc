#include <bindings.dsl.h>
#include <fluidsynth.h>

module Sound.Fluidsynth.Internal where
#strict_import

#opaque_t fluid_settings_t

#ccall new_fluid_settings , IO (Ptr <fluid_settings_t>)
#ccall delete_fluid_settings , Ptr <fluid_settings_t> -> IO ()
#ccall fluid_settings_get_type , Ptr <fluid_settings_t> -> CString -> IO CInt
#ccall fluid_settings_setstr , Ptr <fluid_settings_t> -> CString \
                            -> CString -> IO CInt
#ccall fluid_settings_getstr , Ptr <fluid_settings_t> -> CString \
                            -> Ptr CString -> IO CInt
#ccall fluid_settings_setnum , Ptr <fluid_settings_t> -> CString \
                            -> CDouble -> IO CInt
#ccall fluid_settings_getnum , Ptr <fluid_settings_t> -> CString \
                            -> Ptr CDouble -> IO CInt
#ccall fluid_settings_setint , Ptr <fluid_settings_t> -> CString \
                            -> CInt -> IO CInt
#ccall fluid_settings_getint , Ptr <fluid_settings_t> -> CString \
                            -> Ptr CInt -> IO CInt

#num FLUID_NO_TYPE
#num FLUID_NUM_TYPE
#num FLUID_INT_TYPE
#num FLUID_STR_TYPE
#num FLUID_SET_TYPE

#opaque_t fluid_synth_t

#ccall new_fluid_synth , Ptr <fluid_settings_t> -> IO (Ptr <fluid_synth_t>)
#ccall delete_fluid_synth , Ptr <fluid_synth_t> -> IO ()
#ccall fluid_synth_noteon , Ptr <fluid_synth_t> -> CInt -> CInt -> CInt \
                         -> IO CInt
#ccall fluid_synth_noteoff , Ptr <fluid_synth_t> -> CInt -> CInt -> IO CInt
#ccall fluid_synth_cc , Ptr <fluid_synth_t> -> CInt -> CInt -> CInt -> IO CInt
#ccall fluid_synth_pitch_bend , Ptr <fluid_synth_t> -> CInt -> CInt -> IO CInt
#ccall fluid_synth_pitch_wheel_sens , Ptr <fluid_synth_t> -> CInt -> CInt \
                                   -> IO CInt
#ccall fluid_synth_program_change , Ptr <fluid_synth_t> -> CInt -> CInt \
                                 -> IO CInt
#ccall fluid_synth_bank_select , Ptr <fluid_synth_t> -> CInt -> CInt \
                              -> IO CInt
#ccall fluid_synth_sfload , Ptr <fluid_synth_t> -> CString -> CInt -> IO CInt
#ccall fluid_synth_sfreload , Ptr <fluid_synth_t> -> CUInt -> IO CInt
#ccall fluid_synth_sfunload , Ptr <fluid_synth_t> -> CUInt -> CInt -> IO CInt

#opaque_t fluid_audio_driver_t

#ccall new_fluid_audio_driver , Ptr <fluid_settings_t> \
                             -> Ptr <fluid_synth_t> \
                             -> IO (Ptr <fluid_audio_driver_t>)
#ccall delete_fluid_audio_driver , Ptr <fluid_audio_driver_t> -> IO ()

#opaque_t fluid_player_t

#ccall new_fluid_player , IO (Ptr <fluid_player_t>)
#ccall delete_fluid_player , Ptr <fluid_player_t> -> IO ()
#ccall fluid_player_add , Ptr <fluid_player_t> -> CString -> IO CInt
#ccall fluid_player_play , Ptr <fluid_player_t> -> IO CInt
#ccall fluid_player_stop , Ptr <fluid_player_t> -> IO CInt
#ccall fluid_player_join , Ptr <fluid_player_t> -> IO CInt

#opaque_t fluid_event_t

#ccall new_fluid_event , IO (Ptr <fluid_event_t>)
#ccall delete_fluid_event , Ptr <fluid_event_t> -> IO ()
#ccall fluid_event_set_source , Ptr <fluid_event_t> -> CShort -> IO ()
#ccall fluid_event_set_dest , Ptr <fluid_event_t> -> CShort -> IO ()
#ccall fluid_event_timer , Ptr <fluid_event_t> -> Ptr () -> IO ()
#ccall fluid_event_note , Ptr <fluid_event_t> -> CInt -> CShort -> CShort \
                       -> CUInt -> IO ()
#ccall fluid_event_noteon , Ptr <fluid_event_t> -> CInt -> CShort -> CShort \
                         -> IO ()
#ccall fluid_event_noteoff , Ptr <fluid_event_t> -> CInt -> CShort -> IO ()
#ccall fluid_event_program_change , Ptr <fluid_event_t> -> CInt -> CShort \
                                 -> IO ()
#ccall fluid_event_pitch_bend , Ptr <fluid_event_t> -> CInt -> CInt -> IO ()
#ccall fluid_event_pitch_wheelsens , Ptr <fluid_event_t> -> CInt -> CShort \
                                  -> IO ()
#ccall fluid_event_volume , Ptr <fluid_event_t> -> CInt -> CShort -> IO ()
#ccall fluid_event_get_source , Ptr <fluid_event_t> -> CShort
#ccall fluid_event_get_dest , Ptr <fluid_event_t> -> CShort

#opaque_t fluid_sequencer_t

#callback fluid_event_callback_t , \
          FunPtr (CUInt -> Ptr <fluid_event_t> -> Ptr <fluid_sequencer_t> \
               -> Ptr () -> IO ())

#ccall new_fluid_sequencer , IO (Ptr <fluid_sequencer_t>)
#ccall delete_fluid_sequencer , Ptr <fluid_sequencer_t> -> IO ()
#ccall fluid_sequencer_register_client , Ptr <fluid_sequencer_t> -> CString \
                                      -> Ptr <fluid_event_callback_t> \
                                      -> Ptr () -> IO CShort
#ccall fluid_sequencer_unregister_client , Ptr <fluid_sequencer_t> -> CShort \
                                        -> IO ()
#ccall fluid_sequencer_count_clients , Ptr <fluid_sequencer_t> -> IO CInt
#ccall fluid_sequencer_get_client_id , Ptr <fluid_sequencer_t> -> CInt \
                                    -> IO CShort
#ccall fluid_sequencer_get_client_name , Ptr <fluid_sequencer_t> -> CInt \
                                      -> IO CString
#ccall fluid_sequencer_client_is_dest , Ptr <fluid_sequencer_t> -> CInt \
                                     -> IO CInt
#ccall fluid_sequencer_send_now , Ptr <fluid_sequencer_t> \
                               -> Ptr <fluid_event_t> -> IO ()
#ccall fluid_sequencer_send_at , Ptr <fluid_sequencer_t> \
                               -> Ptr <fluid_event_t> -> CUInt -> Int -> IO ()
#ccall fluid_sequencer_get_tick , Ptr <fluid_sequencer_t> -> IO CUInt
#ccall fluid_sequencer_set_time_scale , Ptr <fluid_sequencer_t> -> CDouble \
                                     -> IO ()
#ccall fluid_sequencer_get_time_scale , Ptr <fluid_sequencer_t> -> IO CDouble

#ccall fluid_sequencer_register_fluidsynth , Ptr <fluid_sequencer_t> \
                                          -> Ptr <fluid_synth_t> -> IO CShort
