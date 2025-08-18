import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/presentation/purchases/bloc/purchase_bloc.dart';
import 'package:shopping/features/purchases/presentation/purchases/bloc/purchase_event.dart';
import 'package:shopping/features/purchases/presentation/purchases/bloc/purchase_state.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key});

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  final _nameFocus = FocusNode();
  final _qtyFocus = FocusNode();
  final _priceFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<PurchaseBloc>().add(const PurchaseStarted());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    _nameFocus.dispose();
    _qtyFocus.dispose();
    _priceFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text.trim();
    final qty = int.parse(_qtyCtrl.text);
    final price = double.parse(_priceCtrl.text.replaceAll(',', '.'));

    context.read<PurchaseBloc>().add(PurchaseAdded(name, qty, price));

    _nameCtrl.clear();
    _qtyCtrl.clear();
    _priceCtrl.clear();
    _nameFocus.requestFocus();
  }

  Future<void> _confirmClearAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Borrar todo'),
        content: const Text('¿Seguro que deseas eliminar todas las compras?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar')),
        ],
      ),
    );
    if (ok == true) {
      // ignore: use_build_context_synchronously
      context.read<PurchaseBloc>().add(PurchaseCleared());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchaseBloc, PurchaseState>(
      listenWhen: (p, n) => p.error != n.error && n.error != null,
      listener: (context, state) {
        final msg = state.error!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Compras'),
          actions: [
            IconButton(
              tooltip: 'Limpiar todo',
              icon: const Icon(Icons.delete_forever_outlined),
              onPressed: _confirmClearAll,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: _nameCtrl,
                          focusNode: _nameFocus,
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                            hintText: 'Arroz, Leche, etc.',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Requerido'
                              : null,
                          onFieldSubmitted: (_) => _qtyFocus.requestFocus(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _qtyCtrl,
                          focusNode: _qtyFocus,
                          decoration:
                              const InputDecoration(labelText: 'Cantidad'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            final n = int.tryParse(v ?? '');
                            if (n == null || n <= 0) return '>= 1';
                            return null;
                          },
                          onFieldSubmitted: (_) => _priceFocus.requestFocus(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: _priceCtrl,
                          focusNode: _priceFocus,
                          decoration: const InputDecoration(
                              labelText: 'Precio unitario'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.,]')),
                          ],
                          textInputAction: TextInputAction.done,
                          validator: (v) {
                            final n =
                                double.tryParse((v ?? '').replaceAll(',', '.'));
                            if (n == null || n <= 0) return '> 0';
                            return null;
                          },
                          onFieldSubmitted: (_) => _submit(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.add),
                        label: const Text('Agregar'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<PurchaseBloc, PurchaseState>(
                    builder: (context, state) {
                      if (state.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.items.isEmpty) {
                        return const Center(child: Text('No hay compras aún'));
                      }
                      return ListView.separated(
                        itemCount: state.items.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) {
                          final item = state.items[i];
                          return Dismissible(
                            key: ValueKey(item.id),
                            background: Container(
                              color: Colors.redAccent.withOpacity(0.15),
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Icon(Icons.delete_outline),
                            ),
                            secondaryBackground: Container(
                              color: Colors.redAccent.withOpacity(0.15),
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Icon(Icons.delete_outline),
                            ),
                            onDismissed: (_) => context
                                .read<PurchaseBloc>()
                                .add(PurchaseDeleted(item.id)),
                            child: _PurchaseTile(item: item),
                          );
                        },
                      );
                    },
                  ),
                ),
                BlocBuilder<PurchaseBloc, PurchaseState>(
                  buildWhen: (p, n) => p.total != n.total,
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.only(top: 8),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Total: S/. ${state.total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PurchaseTile extends StatelessWidget {
  final Purchase item;
  const _PurchaseTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final subtitle =
        'x${item.quantity} · S/. ${item.unitPrice.toStringAsFixed(2)}';
    final right = 'S/. ${item.subtotal.toStringAsFixed(2)}';
    return ListTile(
      title: Text(item.name),
      subtitle: Text(subtitle),
      trailing: Text(
        right,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
