defmodule Primelix.RustlePrime do
  use Rustler, otp_app: :primelix, crate: :rustleprime

  # Stub impl.
  def gen_prime(_max_num), do: :erlang.nif_error(:nif_not_loaded)
end
